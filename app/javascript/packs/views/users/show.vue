<template>
  <v-container fluid>
    <v-card>
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
      <v-tab> よんだ！: {{ Object.keys(readTweets).length }} </v-tab>
      <v-tab> かいた！: {{ Object.keys(comments).length }} </v-tab>
      <v-tab-item>
        <tweetCard
          v-for="tweet in readTweets"
          :tweet="tweet"
          :key="tweet.id"
        ></tweetCard>
      </v-tab-item>
      <v-tab-item>
        <MyCommentCard
          v-for="comment in comments"
          :comment="comment"
          :key="comment.id"
          @update="update"
        ></MyCommentCard>
      </v-tab-item>
    </v-tabs>
  </v-container>
</template>

<script>
import TweetCard from '../../components/tweetCard.vue'
import MyCommentCard from '../../components/comments/myCard.vue'
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
    MyCommentCard,
    UserImage,
  },
}
</script>

<style scoped></style>
