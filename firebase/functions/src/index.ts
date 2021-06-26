import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import * as axios from "axios";

// Start writing Firebase Functions
// https://firebase.google.com/docs/functions/typescript

export const updateapp = functions.https.onRequest(async (request, response) => {
  admin.initializeApp();
  let posts = await admin.firestore().collection('posts').get();
  posts.forEach(post => {
    post.ref.delete();
  });
  let users = await admin.firestore().collection('users').get();
  users.forEach(user => {
    user.ref.delete();
  });
  let categories = await admin.firestore().collection('categories').get();
  categories.forEach(category => {
    category.ref.delete();
  });

  let resp = await axios.default.get('https://auhuurmagazin.de/wp-json/wp/v2/posts?per_page=20&page=1');
  if (resp.status == 200) {
    let data: [] = resp.data;
    data.forEach(element => {
      admin.firestore().collection('posts').add({
        'categoriesId': element['categories'],
        'authorId': element['author'],
        'title': element['title']['rendered'],
        'id': element['id'],
        'date': new Date(element['date']),
        'link': element['link'],
        'featuredMedia': element['jetpack_featured_media_url'],
        'contentHtml': element['content']['rendered'],
        'excerptHtml': element['excerpt']['rendered'],
      });
    });
  } else {
    response.status(400).send('Es ist ein Fehler aufgetreten');
  }
  resp = await axios.default.get('https://auhuurmagazin.de/wp-json/wp/v2/users?per_page=100');
  if (resp.status == 200) {
    let data: [] = resp.data;
    data.forEach(element => {
      admin.firestore().collection('users').add({
        'avatar_url': element['avatar_urls']['96'],
        'description': element['description'],
        'id': element['id'],
        'name': element['name'],
      });
    });
  } else {
    response.status(400).send('Es ist ein Fehler aufgetreten');
  }
  resp = await axios.default.get('https://auhuurmagazin.de/wp-json/wp/v2/categories?per_page=100');
  if (resp.status == 200) {
    let data: [] = resp.data;
    data.forEach(element => {
      admin.firestore().collection('categories').add({
        'id': element['id'],
        'name': element['name'],
      });
    });
  } else {
    response.status(400).send('Es ist ein Fehler aufgetreten');
  }
  response.status(200).send('Alles erledigt');
});

export const newpost = functions.https.onRequest(async (request, response) => {
  admin.initializeApp();
  let resp = await axios.default.get('https://us-central1-aixformation.cloudfunctions.net/updateapp');
  if (resp.status == 200) {
    let docs = await admin.firestore().collection("posts").orderBy("date", "desc").get();
    let postData = docs.docs[0].data();
    let newTitle: string = postData['title'];
    let newImageUrl: string = postData['featuredMedia'];
    let newid: number = postData['id'];
    console.log(newTitle + newImageUrl + newid);
    admin.messaging().send({
      topic: 'all',
      notification: {
        title: 'Für dich | Auhuur Magazin !',
        body: newTitle, imageUrl: newImageUrl,
      },
      data: { 'post_id': newid.toString() },
    });
  } else {
    response.status(400).send('Es ist ein Fehler aufgetreten');
  }
  response.status(200).send('Alles erledigt');
});
