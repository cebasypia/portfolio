<template>
  <v-container fluid>
    <tweetCard :tweet="tweet" :detail="true"></tweetCard>
  </v-container>
</template>

<script>
import TweetCard from '../../components/tweetCard.vue'

import axios from 'axios'

export default {
  data: function () {
    return {
      tweet: [],
    }
  },
  mounted() {
    axios
      .get(`/api/v1/tweets/${this.$route.params.id}`)
      .then((response) => (this.tweet = response.data))
  },
  components: {
    TweetCard,
  },
}
</script>

<style scoped></style>
