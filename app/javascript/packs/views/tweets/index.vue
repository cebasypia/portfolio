<template>
  <v-container fluid>
    <SearchForm @search="search"></SearchForm>
    <tweetCard
      v-for="tweet in tweets"
      :tweet="tweet"
      :key="tweet.id"
    ></tweetCard>
  </v-container>
</template>

<script>
import SearchForm from '../../components/tweets/form.vue'
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
  methods: {
    search(word) {
      if (!word) return
      axios
        .post(`/api/v1/tweets`, {
          word: word,
        })
        .then((response) => (this.tweets = response.data))
    },
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
    SearchForm,
  },
}
</script>

<style scoped></style>
