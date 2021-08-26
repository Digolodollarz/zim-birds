

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
const admin = require("firebase-admin");
const functions = require("firebase-functions");
const csvParser = require("csv-parser");
const fs = require("fs");
const serviceAccountKey = require("/Users/macbook/Development/zim-birds-firebase-adminsdk-443ra-fb6ec3d920.json");
const csvFilePath = "/Users/macbook/Downloads/species_20210817_24627.txt";

admin.initializeApp({
  credential: admin.credential.cert(serviceAccountKey),
});

const firestore = admin.firestore();

const handleError = (error) => {
  // Do something with the error...
  console.log('Error', error);
};

const commitMultiple = (batchFactories) => {
  let result = Promise.resolve();
  /** Waiting 1.2 seconds between writes */
  const TIMEOUT = 1200;

  batchFactories.forEach((promiseFactory, index) => {
    result = result
      .then(() => {
        return new Promise((resolve) => {
          setTimeout(resolve, TIMEOUT);
        });
      })
      .then(promiseFactory)
      .then(() =>
        console.log(`Commited ${index + 1} of ${batchFactories.length}`)
      );
  });

  return result;
};

const api = (req, res) => {
  let currentBatchIndex = 0;
  const batchesArray = [];
  let batchDocsCount = 0;

  batchFactoriesArray.push();

  return Promise.resolve()
    .then(() => {
      const data = [];

      return fs
        .createReadStream(csvFilePath)
        .pipe(csvParser())
        .on("data", (row) => {
          const batch = (() => {
            const batchPart = db.batch();

            if (batchesArray.length === 0) {
              batchesArray.push(batchPart);
            }

            if ((batchDocsCount = 499)) {
              // reset count
              batchDocsCount = 0;
              batchesArray.push(batchPart);

              currentBatchIndex++;
              batchFactories.push(() => batchPart.commit());
            }

            return batchesArray[currentBatchIndex];
          })();

          batchDocsCount++;

          const ref = firestore.collection("my_data").doc();

          batch.set(ref, JSON.parse(row));
        })
        .on("end", resolve);
    })
    .then(() => commitMultiple(batchFactories))
    .then(() => res.json({ done: true }))
    .catch(handleError);
};

module.exports = {
  api: functions
    .runWith({
      timeoutSeconds: 60 * 9, // seconds,
    })
    .https.onRequest(api),
};

