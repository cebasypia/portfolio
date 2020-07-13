<template>
  <v-container fluid>
    <userCard :user="user"></userCard>
    <div class="text-center mb-1">最近のTweet</div>
    <tweetCard
      v-for="tweet in tweets"
      :tweet="tweet"
      :key="tweet.id"
    ></tweetCard>
  </v-container>
</template>

<script>
import axios from 'axios'
import UserCard from '../../components/userCard.vue'
import TweetCard from '../../components/tweetCard.vue'

export default {
  data: function () {
    return {
      user: [],
      tweets: [],
    }
  },
  mounted() {
    axios
      .get(`/api/v1/tweets/user/${this.$route.params.id}`)
      .then((response) => (this.user = response.data))

    axios
      .get(`/api/v1/tweets/user/${this.$route.params.id}/recent`)
      .then((response) => (this.tweets = response.data))
  },
  components: {
    UserCard,
    TweetCard,
  },
}
</script>

<style scoped></style>
