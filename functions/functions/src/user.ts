import * as functions from "firebase-functions";
import { firestore } from "firebase-admin";

export const fs = firestore();

export const onCreateUser = functions.auth.user().onCreate(async user => {
  console.log(
    `=== Creating User ${user.uid} : ${user.email} : ${user.displayName} ===`
  );
  const data = {
    uid: user.uid,
    email: user.email,
    displayName: user.displayName || `Usuario${Math.floor(Math.random()*10000000)}`,
    photoUrl: user.photoURL,
    characters: [],
    games: [],
  };

  const docPath = `users/${user.uid}`;
  const userDocument = fs.doc(docPath);
  const docSnapshot = await userDocument.get();
  try {
    if (docSnapshot.exists) {
      console.error("=== User Document Already Exists ===");
    } else {
      await userDocument.set(data);
    }
  } catch (error) {
    console.error(`=== Error Creating User Document ===`);
    console.error(`Error: ${error.message}`);
    throw new Error(error);
  }
});

export const onDeleteUser = functions.auth.user().onDelete(async user => {
  const docPath = `users/${user.uid}`;
  const userDocument = fs.doc(docPath);
  await userDocument.delete();
});
