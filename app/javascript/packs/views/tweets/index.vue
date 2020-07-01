<template>
  <v-container fluid>
    <tweetCard
      v-for="tweet in tweets"
      :tweet="tweet"
      :key="tweet.id"
    ></tweetCard>
  </v-container>
</template>

<script>
import TweetCard from '../../components/tweetCard.vue'

import axios from 'axios'

export default {
  data: function () {
    return {
      tweets: [],
    }
  },
  mounted() {
    axios
      .get(`/api/v1/tweets/index`)
      .then((response) => (this.tweets = response.data))
  },
  components: {
    TweetCard,
  },
}
</script>

<style scoped></style>
