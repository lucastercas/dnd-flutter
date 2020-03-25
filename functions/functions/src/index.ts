import * as admin from "firebase-admin";

admin.initializeApp();

import * as userFunctions from "./user";
// const bucket = storage().bucket();

module.exports = {
  ...userFunctions
};
