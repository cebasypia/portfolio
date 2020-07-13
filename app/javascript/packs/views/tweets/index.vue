<template>
  <v-container fluid>
    <SearchForm @search="search"></SearchForm>
    <v-alert
      v-if="display_alert"
      border="top"
      colored-border
      type="info"
      elevation="2"
    >
      Tweetが見つかりませんでした
    </v-alert>
    <tweetCard
      v-for="tweet in tweets"
      :tweet="tweet"
      :key="tweet.id"
    ></tweetCard>
    <div class="text-center">
      <v-btn rounded outlined color="primary" dark @click="getNextTweets"
        >次の15件を表示</v-btn
      >
    </div>
  </v-container>
</template>

<script>
import SearchForm from '../../components/tweets/form.vue'
import TweetCard from '../../components/tweetCard.vue'

import axios from 'axios'

export default {
  data: function () {
    return {
      tweets: [],
      display_alert: false,
    }
  },
  methods: {
    search() {
      if (!this.$store.state.searches.word) return
      axios
        .get(`/api/v1/tweets`, { params: this.$store.state.searches })
        .then((response) => (this.tweets = response.data))
    },
    getNextTweets() {
      const searches = Object.assign(
        {},
        JSON.parse(JSON.stringify(this.$store.state.searches)),
        { max_id: this.tweets.slice(-1)[0].id }
      )
      axios.get(`/api/v1/tweets`, { params: searches }).then((response) => {
        for (let tweet of response.data) {
          this.tweets.push(tweet)
        }
        if (this.tweets.length === 0) this.display_alert = true
      })
    },
  },
  mounted() {
    const searches = Object.assign(
      {},
      JSON.parse(JSON.stringify(this.$store.state.searches)),
      JSON.parse(JSON.stringify(this.$attrs))
    )
    axios.get(`/api/v1/tweets`, { params: searches }).then((response) => {
      this.tweets = response.data
      if (this.tweets.length === 0) this.display_alert = true
    })
  },
  components: {
    TweetCard,
    SearchForm,
  },
}
</script>

<style scoped></style>
