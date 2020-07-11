<template>
  <v-card class="tweet-card">
    <v-list-item two-line>
      <v-list-item-avatar size="73" color="grey">
        <router-link
          v-bind:to="{
            name: 'TweetsUserPage',
            params: { id: tweet.user.id },
          }"
        >
          <v-img :src="tweet.user.profile_image_url"></v-img>
        </router-link>
      </v-list-item-avatar>
      <v-list-item-content>
        <v-list-item-subtitle>{{ tweet.created_at }}</v-list-item-subtitle>
        <router-link
          v-bind:to="{
            path: `/tweets/users/${tweet.user.id}`,
          }"
        >
          <v-list-item-title class="user-name">
            {{ tweet.user.name }}
          </v-list-item-title>
        </router-link>
      </v-list-item-content>
    </v-list-item>
    <router-link
      v-bind:to="{
        path: `/tweets/${tweet.id}`,
      }"
    >
      <v-card-text class="text">{{ tweet.full_text }}</v-card-text>
      <div v-if="tweet.entities.media" class="img">
        <v-img :src="tweet.entities.media[0].media_url"></v-img>
      </div>
    </router-link>
    <v-row justify="space-around" fill-height class="info-row">
      <v-col cols="3">
        <a :href="tweet.uri" target="_blank">
          <v-icon class="icon-twitter">mdi-twitter</v-icon>
        </a>
      </v-col>
      <v-col cols="3"> いいね: {{ tweet.favorite_count }} </v-col>
      <v-col cols="auto"> リツイート数: {{ tweet.retweet_count }} </v-col>
    </v-row>
    <ReadButton v-if="auth.logged_in" :tweet_id="tweet.id"></ReadButton>
  </v-card>
</template>

<script>
import ReadButton from './readButton.vue'

import store from '../store.js'

export default {
  props: {
    tweet: {
      type: Object,
    },
  },
  data: function () {
    return {
      auth: store.state.auth,
    }
  },
  components: {
    ReadButton,
  },
}
</script>

<style scoped>
.tweet-card {
  margin-bottom: 1rem;
}
a {
  text-decoration: none;
}
.text {
  color: rgba(0, 0, 0, 0.87);
}
::v-deep .v-image {
  margin: 0.5rem;
  border-radius: 5px;
}
.user-name {
  color: rgba(0, 0, 0, 0.87);
}
.info-row {
  font-size: 12px;
  color: rgba(0, 0, 0, 0.6);
}
.icon-twitter {
  color: rgb(29, 161, 242);
}
</style>
