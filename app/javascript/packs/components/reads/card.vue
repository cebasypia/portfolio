<template>
  <v-card class="read-card align-center mx-auto">
    <v-list-item two-line>
      <UserImage :size="73" :user="read.user"></UserImage>
      <v-list-item-content>
        <v-list-item-title>
          {{ read.user.name }}
        </v-list-item-title>
      </v-list-item-content>
    </v-list-item>
    <v-card-text> {{ read.created_at }} によんだ！ </v-card-text>
    <div class="tweet-card-container">
      <TweetCardMini class="tweet-card" :tweet="read.tweet"></TweetCardMini>
    </div>
  </v-card>
</template>
<script>
import UserImage from '../userImage.vue'
import TweetCardMini from '../tweetCardMini.vue'

export default {
  props: ['read'],
  data: function () {
    return {}
  },
  methods: {},
  components: {
    UserImage,
    TweetCardMini,
  },
}
</script>

<style scoped>
.read-card {
  margin-bottom: 1rem;
}
.tweet-card {
  box-shadow: initial !important;
  border-color: rgba(0, 172, 237, 1);
  border-style: solid;
}
.tweet-card-container {
  padding: 1rem;
}
</style>
