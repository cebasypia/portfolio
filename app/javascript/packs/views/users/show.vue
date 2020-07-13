<template>
  <v-container fluid>
    <v-card class="user-card">
      <v-list-item two-line>
        <UserImage :user="user" :is_link="false"></UserImage>
        <v-list-item-content>
          <v-list-item-title class="user-name">
            {{ user.name }}
          </v-list-item-title>
        </v-list-item-content>
      </v-list-item>
      <v-card-text class="text">{{ user.profile }}</v-card-text>
    </v-card>
    <v-tabs fixed-tabs light color="amber darken-2">
      <v-tab>
        <v-icon>mdi-folder-heart</v-icon>
        <span>よんだ！: {{ Object.keys(readTweets).length }}</span>
      </v-tab>
      <v-tab>
        <v-icon>mdi-lead-pencil</v-icon>
        かいた！: {{ Object.keys(comments).length }}
      </v-tab>
      <v-tab-item>
        <tweetCard
          v-for="tweet in readTweets"
          :tweet="tweet"
          :key="tweet.id"
        ></tweetCard>
      </v-tab-item>
      <v-tab-item>
        <CommentCard
          v-for="comment in comments"
          :comment="comment"
          :key="comment.id"
          :display_user="false"
          @update="update"
        ></CommentCard>
      </v-tab-item>
    </v-tabs>
  </v-container>
</template>

<script>
import TweetCard from '../../components/tweetCard.vue'
import CommentCard from '../../components/comments/card.vue'
import UserImage from '../../components/userImage.vue'

import axios from 'axios'

export default {
  data: function () {
    return {
      user: {},
      readTweets: {},
      comments: {},
    }
  },
  mounted() {
    axios
      .get(`/api/v1/users/${this.$route.params.id}.json`)
      .then((response) => {
        this.user = response.data
      })
    axios
      .get(`/api/v1/reads/user/${this.$route.params.id}.json`)
      .then((response) => {
        this.readTweets = response.data
      })
    axios
      .get(`/api/v1/comments/user/${this.$route.params.id}.json`)
      .then((response) => {
        this.comments = response.data
      })
  },
  methods: {
    update() {
      axios
        .get(`/api/v1/comments/user/${this.$route.params.id}.json`)
        .then((response) => {
          this.comments = response.data
        })
    },
  },
  components: {
    TweetCard,
    CommentCard,
    UserImage,
  },
}
</script>

<style scoped>
.user-card {
  margin-bottom: 1rem;
}
</style>
