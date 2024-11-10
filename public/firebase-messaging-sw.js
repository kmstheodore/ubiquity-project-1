importScripts('https://www.gstatic.com/firebasejs/11.0.1/firebase-app.js');
importScripts('https://www.gstatic.com/firebasejs/11.0.1/firebase-messaging.js');

const firebaseConfig = {
  apiKey: "AIzaSyBuEc82Ac0EULB5XIiuolF7J671jeecSXc",
  authDomain: "ubiquityproject.co.uk",
  projectId: "ubiquity-project-app",
  storageBucket: "ubiquity-project-app.firebasestorage.app",
  messagingSenderId: "65866574535",
  appId: "1:65866574535:web:7d307be893d491da4face2",
  measurementId: "G-KYM0K5G00G"
};

firebase.initializeApp(firebaseConfig);

// Get Firebase messaging instance
const messaging = firebase.messaging();

// Handle background notifications
messaging.onBackgroundMessage(function(payload) {
  console.log("Received background message ", payload);
  const notificationTitle = "New Reminder";
  const notificationOptions = {
    body: payload.notification.body,
    icon: "/firebase-logo.png"  // Replace with your icon if needed
  };

  self.registration.showNotification(notificationTitle, notificationOptions);
});
