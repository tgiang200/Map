$(document).ready(function() {
    // Can khoi tao 2 Button login va logout trong HTML
    setLoginButton('btn-login', 'btn-logout');
    // --> Neu giao dien khong can 2 nut nay thi co the set trong css: "display: hidden;"

    // Can khoi tao 4 Button trong HTML de xu ly qua trinh call
    // --> 1: Call : goi
    // --> 2: Hangup : cup may
    // --> 3: Answer : tra loi cuoc goi
    // --> 4: Reject : tu choi cuoc goi
    setCallButtons('btn-call', 'btn-hangup', 'btn-answer', 'btn-reject');

    prepare();

    // Dang nhap sip account : co the goi khi button onclick
    $('#btn-login').click(function () {
        // Thiet lap thong tin User
        var serverAddr = $('#txt-serverAddr').val()
        var sipAccount = $('#txt-sipAccount').val() + '@' + serverAddr;
        var password = $('#txt-password').val();

        setUserInfo('Chau Quoc Minh', sipAccount, password, serverAddr);

        // Thiet lap server:
        // --> Neu dung May ao Server thi dua vao dia chi server
        // --> Neu dung Remote Server thi set null
        setServerAddress(serverAddr);

        onClickLogin();
    });

    // Xu ly logout:
    $('#btn-logout').click(function() {
        onClickLogout();
    });

    // Goi thong qua SIP address:
    $('#btn-call').click(function() {
        makeVoiceCall($('#txt-sendTo').val());
    });

    // Lang nghe su kien cup may:
    $('#btn-hangup').click(function() {
        sipHangUp();
    });

    // Xu ly nut "Send message"
    $('#btn-send').click(function() {
        var msg = $('#txtMessage').val();

        // createMessageSession();
        sendMessage($('#txt-sendTo').val(), msg);

        displaySendMessage(msg);

        $('#txtMessage').val("");
    });
});

function displaySendMessage(message) {
    var displayName = "Chau Quoc Minh";
    $('#messageView').append("<p>" + displayName + ": " + message + "</p>");
}

// Xu ly tien trinh nhan tin nhan trong ham nay
// VD: set tin nhan len giao dien, luu vao csdl ...
// *** Ghi chu: dung su kien "e" de xu ly
function handleMessaging(e) {
    displayReceivedMessage(e);
}

function displayReceivedMessage(e) {
    var displayName = 'cqm1';
    var message = e.getContentString();
    $('#messageView').append("<p>" + displayName + ": " + message + "</p>");
}
