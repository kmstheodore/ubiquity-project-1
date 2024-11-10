// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import { initializeApp } from "firebase/app";
import { getMessaging, getToken, onMessage } from "firebase/messaging";

// Configure your Firebase app with your Firebase project details
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

// Request notification permission and get token for push notifications
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
      // Send this token to your server or store it for later use
    }
  })
  .catch((error) => {
    console.error("Error getting notification permission or token:", error);
  });

// Handle incoming messages when the app is in the foreground
onMessage(messaging, (payload) => {
  console.log("Message received:", payload);
  // Show a notification with the message payload
  const notificationTitle = "New Reminder";
  const notificationOptions = {
    body: payload.notification.body,
    icon: "/firebase-logo.png" // Replace with your own icon if needed
  };

  // Display the notification
  new Notification(notificationTitle, notificationOptions);
});
