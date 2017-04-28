var SERVER_ADDR;
var sipStack;
var oSessionIM;
var registerSession;
var callSession;
var audioRemote;
var configCall;
var btnLogin, btnLogout;
var btnCall, btnAnswer, btnHangUp, btnReject;
var displayName, userName, password, domain;
var oldRecvMsg, newRecvMsg;

function prepare(){
    window.console && window.console.info && window.console.info("location=" + window.location);

    audioRemote = document.getElementById('audio_remote');

    // Set default option:
    disableButton(btnLogout);
    disableButton(btnCall);
    disableButton(btnHangUp);
    hideButton(btnAnswer);
    hideButton(btnReject);

    var getPVal = function (PName) {
        var query = window.location.search.substring(1);
        var vars = query.split('&');
        for (var i = 0; i < vars.length; i++) {
            var pair = vars[i].split('=');
            if (decodeURIComponent(pair[0]) === PName) {
                return decodeURIComponent(pair[1]);
            }
        }
        return null;
    }

    var preInit = function () {
        // set default webrtc type (before initialization)
        var s_webrtc_type = getPVal("wt");
        var s_fps = getPVal("fps");
        var s_mvs = getPVal("mvs"); // maxVideoSize
        var s_mbwu = getPVal("mbwu"); // maxBandwidthUp (kbps)
        var s_mbwd = getPVal("mbwd"); // maxBandwidthUp (kbps)
        var s_za = getPVal("za"); // ZeroArtifacts
        var s_ndb = getPVal("ndb"); // NativeDebug

        if (s_webrtc_type) SIPml.setWebRtcType(s_webrtc_type);

        // initialize SIPML5
        SIPml.init(postInit);

        // set other options after initialization
        if (s_fps) SIPml.setFps(parseFloat(s_fps));
        if (s_mvs) SIPml.setMaxVideoSize(s_mvs);
        if (s_mbwu) SIPml.setMaxBandwidthUp(parseFloat(s_mbwu));
        if (s_mbwd) SIPml.setMaxBandwidthDown(parseFloat(s_mbwd));
        if (s_za) SIPml.setZeroArtifacts(s_za === "true");
        if (s_ndb == "true") SIPml.startNativeDebug();

    }

    oReadyStateTimer = setInterval(function () {
        if (document.readyState === "complete") {
            clearInterval(oReadyStateTimer);
            // initialize SIPML5
            preInit();
        }
    },
    500);
}

function postInit() {
    // check for WebRTC support
    if (!SIPml.isWebRtcSupported()) {
        // is it chrome?
        if (SIPml.getNavigatorFriendlyName() == 'chrome') {
            if (confirm("You're using an old Chrome version or WebRTC is not enabled.\nDo you want to see how to enable WebRTC?")) {
                window.location = 'http://www.webrtc.org/running-the-demos';
            }
            else {
                window.location = "index.html";
            }
            return;
        }
        else {
            if (confirm("webrtc-everywhere extension is not installed. Do you want to install it?\nIMPORTANT: You must restart your browser after the installation.")) {
                window.location = 'https://github.com/sarandogou/webrtc-everywhere';
            }
            else {
                // Must do nothing: give the user the chance to accept the extension
                // window.location = "index.html";
            }
        }
        if (confirm('Your browser don\'t support WebRTC.\naudio/video calls will be disabled.\nDo you want to download a WebRTC-capable browser?')) {
            window.location = 'https://www.google.com/intl/en/chrome/browser/';
        }
    }

    // checks for WebSocket support
    if (!SIPml.isWebSocketSupported()) {
        if (confirm('Your browser don\'t support WebSockets.\nDo you want to download a WebSocket-capable browser?')) {
            window.location = 'https://www.google.com/intl/en/chrome/browser/';
        }
        else {
            window.location = "index.html";
        }
        return;
    }

    configCall = {
        audio_remote: audioRemote,
        bandwidth: { audio: undefined, video: undefined },
        events_listener: { events: '*', listener: onSipEventSession },
        sip_caps: [
                        { name: '+g.oma.sip-im' },
                        { name: 'language', value: '\"en,fr\"' }
        ]
    };
}

function setServerAddress(serverAddress) {
    SERVER_ADDR = serverAddress;
    console.error(SERVER_ADDR);
}

function createSipStack() {
    sipStack = new SIPml.Stack(
        {
            display_name: displayName,
            realm: domain,
            impi: userName,
            impu: 'sip:' + userName + '@' + domain,
            password: password,
            websocket_proxy_url: (SERVER_ADDR != null ? 'ws://' + SERVER_ADDR + ':5060/ws' : null),
                // (null),
                // 'ws://' + SERVER_ADDR + ':5060/ws',
            enable_rtcweb_breaker: true,
            sip_headers: [
                { name: 'User-Agent', value: 'IM-client/OMA1.0 sipML5-v1.2015.03.18' },
                { name: 'Organization', value: 'Doubango Telecom' }
            ],
            events_listener: { events: '*', listener: onSipEventStack }
        }
    )
}

function onClickLogin() {
    createSipStack();

    sipStack.start();
}

var onClickLogout = function(e) {
    if(sipStack) {
        sipStack.stop();
        printMessage('disconnected');

        enableButton(btnLogin);
        disableButton(btnLogout);
        disableButton(btnCall);
        disableButton(btnHangUp);
    }
}

function login() {
    // catch exception for IE (DOM not ready)
    try {
        // LogIn (REGISTER) as soon as the stack finish starting
        registerSession = sipStack.newSession('register', {
            expires: 200,
            events_listener: { events: '*', listener: onSipEventSession },
            sip_caps: [
                { name: '+g.oma.sip-im', value: null },
                //{ name: '+sip.ice' }, // rfc5768: FIXME doesn't work with Polycom TelePresence
                { name: '+audio', value: null },
                { name: 'language', value: '\"en,fr\"' }
            ]
        });
        registerSession.register();
        createMessageSession();
    }
    catch (e) {
        printMessage("<b>1:" + e + "</b>");
        disableButton(btnLogin);
    }
}

function makeVoiceCall(sipAddress) {
    if(sipStack && !callSession && !tsk_string_is_null_or_empty(sipAddress)) {
        callSession = sipStack.newSession( 'call-audio', configCall );

        disableButton(btnHangUp);
        enableButton(btnCall);

        if (callSession.call(sipAddress) != 0){
            callSession = null;
            printMessage('Failed to make call');
            disableButton(btnCall);
            enableButton(btnHangUp);

            return;
        }
    }
}

function incomingCallProgress() {
    incomingCallUIButton()

    // var btnAnswer = document.getElementById('btnAnswer');
    // var btnReject = document.getElementById('btnReject');
    btnAnswer.onclick = function () {
        if(callSession) {
            printMessage('<i>Connecting...</i>');
            callSession.accept(configCall);

            normalUIButton()
        }
    }
    btnReject.onclick = function () {
        sipHangUp();

        normalUIButton()
    }
}

// terminates the call (SIP BYE or CANCEL)
function sipHangUp() {
    if (callSession) {
        printMessage('<i>Terminating the call...</i>');
        callSession.hangup({ events_listener: { events: '*', listener: onSipEventSession } });
    }
}

function callTerminated(s_description) {
    // Set text for button:
    enableButton(btnCall);
    disableButton(btnHangUp);

    callSession = null;

    stopRingbackTone();
    stopRingTone();

    printMessage("<i> callTerminated: " + s_description + "</i>")

    setTimeout(function () { if (!callSession) printMessage(''); }, 2500);
}

function printMessage(message) {
    document.getElementById('status').innerHTML = message;
}

function disableButton(buttonId) {
    document.getElementById(buttonId).disabled = true;
}

function enableButton(buttonId) {
    document.getElementById(buttonId).disabled = false;
}

function hideButton(buttonId) {
    document.getElementById(buttonId).style.display = 'none';
}

function showButton(buttonId) {
    document.getElementById(buttonId).style.display = 'inline';
}

// Callback function for SIP Stacks
function onSipEventStack(e /*SIPml.Stack.Event*/) {
    tsk_utils_log_info('==stack event = ' + e.type);
    switch (e.type) {
        case 'started':
            {
                login();
                break;
            }
        case 'stopping': case 'stopped': case 'failed_to_start': case 'failed_to_stop':
            {
                var bFailure = (e.type == 'failed_to_start') || (e.type == 'failed_to_stop');
                sipStack = null;
                registerSession = null;
                callSession = null;

                stopRingbackTone();
                stopRingTone();

                printMessage(bFailure ? "<i>Disconnected: <b>" + e.description + "</b></i>" : "<i>Disconnected</i>");
                break;
            }

        case 'i_new_call':
            {
                if (callSession) {
                    // do not accept the incoming call if we're already 'in call'
                    e.newSession.hangup(); // comment this line for multi-line support
                }
                else {
                    callSession = e.newSession;
                    // start listening for events
                    callSession.setConfiguration(configCall);

                    // Handle progress
                    incomingCallProgress();

                    startRingTone();

                    var sRemoteNumber = (callSession.getRemoteFriendlyName() || 'unknown');
                    printMessage("<i>Incoming call from [<b>" + sRemoteNumber + "</b>]</i>");
                }
                break;
            }

        case 'i_new_message' :
            {
                e.newSession.accept();

                oldRecvMsg = localStorage.getItem('oldRecvMsg');
                newRecvMsg = e.getContentString();

                console.error('id_old_message_session: ' + oldRecvMsg);
                console.error('id_new_message_session: ' + newRecvMsg);

                if(oldRecvMsg != newRecvMsg) {
                    localStorage.setItem('oldRecvMsg', newRecvMsg);
                    handleMessaging(e);
                }

                break;
            }

        case 'm_permission_requested':
            {
                break;
            }
        case 'm_permission_accepted':
        case 'm_permission_refused':
            {
                if (e.type == 'm_permission_refused') {
                    callTerminated('Media stream permission denied');
                }
                break;
            }

        case 'starting': default: break;
    }
};

// Callback function for SIP sessions (INVITE, REGISTER, MESSAGE...)
function onSipEventSession(e /* SIPml.Session.Event */) {
    tsk_utils_log_info('==session event = ' + e.type);

    switch (e.type) {
        case 'connecting': case 'connected':
            {
                var connected = (e.type == 'connected');
                if (e.session == registerSession) {
                    disableButton(btnLogin);
                    enableButton(btnLogout);
                    enableButton(btnCall);

                    printMessage(e.description);
                }
                else if (e.session == callSession) {
                    enableButton(btnHangUp);
                    disableButton(btnCall);

                    if (connected) {
                        stopRingbackTone();
                        stopRingTone();
                    }

                    printMessage(e.description);
                }
                break;
            } // 'connecting' | 'connected'
        case 'terminating': case 'terminated':
            {
                if (e.session == registerSession) {
                    callSession = null;
                    registerSession = null;

                    printMessage("<i>" + e.description + "</i>")
                }
                else if (e.session == callSession) {
                    callTerminated(e.description);
                }
                break;
            } // 'terminating' | 'terminated'

        case 'm_stream_audio_local_added':
        case 'm_stream_audio_local_removed':
        case 'm_stream_audio_remote_added':
        case 'm_stream_audio_remote_removed':
            {
                break;
            }

        case 'i_ect_new_call':
            {
                break;
            }

        case 'i_ao_request':
            {
                if (e.session == callSession) {
                    var iSipResponseCode = e.getSipResponseCode();
                    if (iSipResponseCode == 180 || iSipResponseCode == 183) {
                        startRingbackTone();
                        printMessage('<i>Remote ringing...</i>');
                    }
                }
                break;
            }

        case 'm_early_media':
            {
                if (e.session == callSession) {
                    stopRingbackTone();
                    stopRingTone();
                    printMessage('<i>Early media started</i>');
                }
                break;
            }

    }
}

function createMessageSession() {
    oSessionIM = sipStack.newSession('message', {
        events_listener: {events: '*', listener: onSipEventStack}
    });
}

function sendMessage(sipAddr, message) {
    oSessionIM.send(sipAddr, message, 'text/plain;charset=utf-8');
}

function setUserInfo(displayName, userName, password, domain) {
    this.displayName = displayName;
    this.userName = userName;
    this.password = password;
    this.domain = domain;
}

function setLoginButton(btnLogin_Id, btnLogout_Id) {
    btnLogin = document.getElementById(btnLogin_Id);
    btnLogout = document.getElementById(btnLogout_Id);
}

function setCallButtons(btnCall_Id, btnHangUp_Id, btnAnswer_Id, btnReject_Id) {
    btnCall = document.getElementById(btnCall_Id);
    btnHangUp = document.getElementById(btnHangUp_Id);
    btnAnswer = document.getElementById(btnAnswer_Id);
    btnReject = document.getElementById(btnReject_Id);
}

function setServerAddress(serverAddress) {
    SERVER_ADDR = serverAddress;
}

function disableButton(button) {
    button.disabled = true;
}

function enableButton(button) {
    button.disabled = false;
}

function hideButton(button) {
    button.style.display = 'none';
}

function showButton(button) {
    button.style.display = 'inline';
}

function normalUIButton() {
    showButton(btnCall);
    showButton(btnHangUp);
    hideButton(btnAnswer);
    hideButton(btnReject);
}

function incomingCallUIButton() {
    hideButton(btnCall);
    hideButton(btnHangUp);
    showButton(btnAnswer);
    showButton(btnReject);
}

function startRingTone() {
    try { ringtone.play(); }
    catch (e) { }
}

function stopRingTone() {
    try { ringtone.pause(); }
    catch (e) { }
}

function startRingbackTone() {
    try { ringbacktone.play(); }
    catch (e) { }
}

function stopRingbackTone() {
    try { ringbacktone.pause(); }
    catch (e) { }
}
