// Firebase Config
const serviceAccount = require("./serviceAccount.json");
const firestoreService = require("firestore-export-import");

const firebaseConfig = {
  apiKey: "AIzaSyD5lmd0tk2aFXC2xgXVNJp0NgHHIhGp-bI",
  authDomain: "dnd-flutter.firebaseapp.com",
  databaseURL: "https://dnd-flutter.firebaseio.com",
  projectId: "dnd-flutter",
  storageBucket: "dnd-flutter.appspot.com",
  messagingSenderId: "243424590155",
  appId: "1:243424590155:web:1e992da7b652fb151810ce",
  measurementId: "G-KBCFNQJWRM"
};

const jsonToFirestore = async () => {
  try {
    console.log("Initialzing Firebase");
    await firestoreService.initializeApp(
      serviceAccount,
      firebaseConfig.databaseURL
    );
    console.log("Firebase Initialized");

    await firestoreService.restore("./characters.json");
    await firestoreService.restore("./weapons.json");
    await firestoreService.restore("./spells.json");
    console.log("Upload Success");
  } catch (error) {
    console.log(error);
  }
};

jsonToFirestore();
