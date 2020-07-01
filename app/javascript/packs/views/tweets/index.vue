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
  props: {
    word: {
      type: String,
      default: 'japan',
    },
  },
  data: function () {
    return {
      tweets: [],
    }
  },
  mounted() {
    axios
      .post(`/api/v1/tweets`, {
        word: this.$props.word,
      })
      .then((response) => (this.tweets = response.data))
  },
  components: {
    TweetCard,
  },
}
</script>

<style scoped></style>
