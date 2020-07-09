<template>
  <v-container fluid>
    <TweetCard :tweet="tweet" :detail="true"></TweetCard>
    <CommentBase v-if="auth.logged_in"></CommentBase>
  </v-container>
</template>

<script>
import TweetCard from '../../components/tweetCard.vue'
import CommentBase from '../../components/comments/base.vue'

import axios from 'axios'
import store from '../../store.js'

export default {
  data: function () {
    return {
      tweet: [],
      auth: store.state.auth,
    }
  },
  mounted() {
    axios
      .get(`/api/v1/tweets/${this.$route.params.id}`)
      .then((response) => (this.tweet = response.data))
  },
  components: {
    TweetCard,
    CommentBase,
  },
}
</script>

<style scoped></style>
