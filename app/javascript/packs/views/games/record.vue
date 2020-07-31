<template>
  <v-container fluid>
    <v-card class="score d-flex align-center">
      <v-list-item two-line>
        <v-list-item-content class="text-center">
          <v-list-item-subtitle>score</v-list-item-subtitle>
          <v-list-item-title>
            {{ score }}
          </v-list-item-title>
          <v-list-item-subtitle></v-list-item-subtitle>
        </v-list-item-content>
      </v-list-item>
    </v-card>
    <tweet-card
      v-for="tweet in tweets"
      :tweet="tweet"
      :key="tweet.id"
      :show_user="false"
      :show_score="true"
    ></tweet-card>
    <v-row class="bottom" align="center">
      <v-col class="text-center" cols="6">
        <v-btn class="button-color" rounded dark @click="replay">REPLAY</v-btn>
      </v-col>
      <v-col class="text-center" cols="6">
        <v-btn class="button-color" rounded dark @click="home">HOME</v-btn>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import TweetCard from '../../components/games/tweetCard.vue'

export default {
  props: {
    tweets: Array,
  },
  data: function () {
    return {}
  },
  methods: {
    replay() {
      this.$router.push({ name: 'GamesIndexPage' })
    },
    home() {
      this.$router.push({ name: 'TweetsIndexPage' })
    },
  },
  computed: {
    score() {
      let result = 0
      this.tweets.forEach((tweet) => {
        result += tweet.score.value
      })
      return result
    },
  },
  components: {
    TweetCard,
  },
}
</script>

<style scoped>
.score {
  text-align: center;
  width: 100px;
  height: 100px;
  margin: 1rem auto;
  border-radius: 50%;
  border: solid 3px #00acee !important;
}
.bottom {
  position: fixed;
  bottom: 0px;
  width: 100%;
  height: 60px;
  z-index: 10;
  background-color: #fff;
}
.button-color {
  background-color: #00acee !important;
  border-color: #00acee !important;
}
</style>
