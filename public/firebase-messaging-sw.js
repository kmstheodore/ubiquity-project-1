// Import Firebase SDKs
importScripts('https://www.gstatic.com/firebasejs/11.0.1/firebase-app.js');
importScripts('https://www.gstatic.com/firebasejs/11.0.1/firebase-messaging.js');

// Initialize Firebase with your project config
const firebaseConfig = {
  apiKey: "AIzaSyBuEc82Ac0EULB5XIiuolF7J671jeecSXc",
  authDomain: "ubiquityproject.co.uk",
  projectId: "ubiquity-project-app",
  storageBucket: "ubiquity-project-app.firebasestorage.app",
  messagingSenderId: "65866574535",
  appId: "1:65866574535:web:7d307be893d491da4face2",
  measurementId: "G-KYM0K5G00G"
};

// Initialize Firebase
firebase.initializeApp(firebaseConfig);

// Get Firebase Messaging instance
const messaging = firebase.messaging();

// Handle background messages (when app is closed or in the background)
messaging.onBackgroundMessage(function(payload) {
  console.log("Received background message ", payload);

  const notificationTitle = payload.notification.title;
  const notificationOptions = {
    body: payload.notification.body,
    icon: payload.notification.icon || "/firebase-logo.png" // Replace with your own icon if needed
  };

  // Show notification
  self.registration.showNotification(notificationTitle, notificationOptions);
});
