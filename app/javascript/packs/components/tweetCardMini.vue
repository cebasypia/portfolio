<template>
  <v-card @click="linkTo(`/tweets/${tweet.id}`)">
    <v-list-item two-line>
      <v-list-item-avatar size="48" color="grey">
        <v-img :src="tweet.user.profile_image_url"></v-img>
      </v-list-item-avatar>
      <v-list-item-content>
        <v-list-item-title class="user-name">
          {{ tweet.user.name }}
        </v-list-item-title>
      </v-list-item-content>
    </v-list-item>
    <v-card-text v-if="tweet.error" class="error-text">{{
      tweet.error
    }}</v-card-text>
    <v-card-text class="text">{{ tweet.full_text }}</v-card-text>
    <v-row justify="space-around" fill-height class="info-row">
      <v-col cols="auto"> いいね: {{ tweet.favorite_count }} </v-col>
      <v-col cols="auto"> リツイート数: {{ tweet.retweet_count }} </v-col>
    </v-row>
  </v-card>
</template>

<script>
import router from '../router.js'

export default {
  props: { tweet: Object },
  methods: {
    linkTo: (path) => {
      router.push({ path: path })
    },
  },
}
</script>

<style scoped>
a {
  text-decoration: none;
}
.error-text {
  color: red !important;
}
.text {
  color: rgba(0, 0, 0, 0.87);
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
