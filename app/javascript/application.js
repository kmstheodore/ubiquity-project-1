// Import necessary modules
import "@hotwired/turbo-rails"
import "controllers"
import { initializeApp } from "firebase/app";
import { getMessaging, getToken, onMessage } from "firebase/messaging";

// Configure Firebase with your project config
const firebaseConfig = {
  apiKey: "AIzaSyBuEc82Ac0EULB5XIiuolF7J671jeecSXc", // Replace with your API key
  authDomain: "ubiquityproject.co.uk", // Replace with your auth domain
  projectId: "ubiquity-project-app", // Replace with your project ID
  storageBucket: "ubiquity-project-app.firebasestorage.app", // Replace with your storage bucket
  messagingSenderId: "65866574535", // Replace with your messaging sender ID
  appId: "1:65866574535:web:7d307be893d491da4face2", // Replace with your app ID
  measurementId: "G-KYM0K5G00G" // Replace with your measurement ID (optional)
};

// Initialize Firebase app
const app = initializeApp(firebaseConfig);

// Initialize Firebase Cloud Messaging
const messaging = getMessaging(app);

// Request notification permission and get the token for push notifications
Notification.requestPermission()
  .then((permission) => {
    if (permission === "granted") {
      console.log("Notification permission granted.");

      // Get the FCM token for the device
      return getToken(messaging, { vapidKey: "BKYwWFf2ubt7ZEkXX9Vl3D36GqVYzGM6mfZRJGXUiktmXf5koPGg0IkV-6jdGG-Wlc0XcUDoeJ9Evki1rovuE2M" });
    } else {
      console.log("Unable to get permission to notify.");
    }
  })
  .then((token) => {
    if (token) {
      console.log("Firebase token received:", token);

      // Send this token to your server to store it
      sendTokenToServer(token);
    }
  })
  .catch((error) => {
    console.error("Error getting notification permission or token:", error);
  });

if ('serviceWorker' in navigator) {
  navigator.serviceWorker.register('/firebase-messaging-sw.js')
    .then((registration) => {
      console.log("Service Worker registered with scope:", registration.scope);
    })
    .catch((error) => {
      console.error("Service Worker registration failed:", error);
    });
}

// Function to send the token to your Rails server
function sendTokenToServer(token) {
  fetch('/save_fcm_token', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
    },
    body: JSON.stringify({ fcm_token: token })
  })
  .then(response => {
    if (response.ok) {
      console.log("Token successfully sent to the server");
    } else {
      console.error("Failed to send token to the server");
    }
  })
  .catch(error => {
    console.error("Error sending token to the server:", error);
  });
}

// Handle incoming messages when the app is in the foreground
onMessage(messaging, (payload) => {
  console.log("Message received in foreground:", payload);
  const notificationTitle = "New Reminder";
  const notificationOptions = {
    body: payload.notification.body,
    icon: "/firebase-logo.png" // Replace with your own icon if needed
  };

  // Display notification
  new Notification(notificationTitle, notificationOptions);
});
