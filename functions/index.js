const { onDocumentCreated } = require('firebase-functions/v2/firestore');
const { logger } = require('firebase-functions');
const { getFirestore } = require('firebase-admin/firestore');
const { getMessaging } = require('firebase-admin/messaging');
const { initializeApp } = require('firebase-admin/app');

initializeApp();

// Sends an urgent alert to matching, opted-in donors in the request city.
exports.notifyMatchingDonors = onDocumentCreated('requests/{requestId}', async event => {
  const request = event.data.data();
  if (!request.isUrgent || !request.isOpen) return;

  const donors = await getFirestore().collection('donors')
    .where('city', '==', request.city)
    .where('available', '==', true)
    .where('bloodType', 'in', request.compatibleTypes)
    .get();
  const tokens = donors.docs.flatMap(doc => doc.data().fcmTokens || []);
  if (!tokens.length) return;

  const response = await getMessaging().sendEachForMulticast({
    tokens,
    notification: {
      title: `Urgent ${request.bloodType} need nearby`,
      body: `${request.hospital} needs ${request.units} unit(s) in ${request.city}.`,
    },
    data: { requestId: event.params.requestId, type: 'urgent_request' },
    android: { priority: 'high' },
  });
  logger.info(`Alerted ${response.successCount} donors for ${event.params.requestId}`);
});
