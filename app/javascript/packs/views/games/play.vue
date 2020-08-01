<template>
  <v-container fluid>
    <v-alert
      v-if="display_alert"
      border="top"
      colored-border
      type="info"
      elevation="2"
    >
      Tweetが見つかりませんでした
    </v-alert>
    <transition name="score">
      <v-card class="score-view mb-2" v-if="show">
        <v-list-item two-line>
          <v-list-item-content>
            <v-col cols="6">
              <v-list-item-subtitle class="mb-1">正解</v-list-item-subtitle>
              <v-list-item-title>
                {{ tweets[id].score.correct_answer }}
              </v-list-item-title>
            </v-col>
            <v-col cols="6">
              <v-list-item-subtitle class="mb-1">回答</v-list-item-subtitle>
              <v-list-item-title>
                {{ tweets[id].score.answer }}
              </v-list-item-title>
            </v-col>
          </v-list-item-content>
        </v-list-item>
        <v-list-item two-line>
          <v-list-item-content>
            <v-list-item-subtitle class="mb-1">誤差</v-list-item-subtitle>
            <v-list-item-title class="score">
              {{ tweets[id].score.diff }}
            </v-list-item-title>
          </v-list-item-content>
        </v-list-item>
      </v-card>
    </transition>
    <TweetCard :tweet="tweets[id]"></TweetCard>
    <div class="bottom text-center">
      <v-slider
        v-model="answer"
        min="-1"
        max="1"
        step="0.1"
        append-icon="mdi-thumb-up"
        prepend-icon="mdi-thumb-down"
        @click:append="incrementScore"
        @click:prepend="decrementScore"
        thumb-label="always"
      ></v-slider>
      <v-btn
        v-show="button"
        color="amber darken-2"
        rounded
        dark
        @click="submit"
      >
        ANSWER
      </v-btn>
      <v-btn v-show="!button" class="twitter-color" rounded dark @click="next">
        Next
      </v-btn>
    </div>
  </v-container>
</template>

<script>
import TweetCard from '../../components/games/tweetCard.vue'

import axios from 'axios'

export default {
  data: function () {
    return {
      tweets: [],
      display_alert: false,
      id: 0,
      answer: 0,
      show: false,
      button: true,
    }
  },
  methods: {
    submit() {
      const score = this.tweets[this.id].score
      score.answer = this.answer
      score.diff = Math.abs(score.correct_answer - score.answer)
      score.value = (2 - score.diff) * 10
      this.show = true
      this.button = false
    },
    next() {
      if (this.id === this.tweets.length - 1) {
        return this.$router.push({
          name: 'GamesRecordPage',
          params: { tweets: this.tweets },
        })
      }
      this.answer = 0
      this.show = false
      this.id += 1
      this.button = true
    },
    incrementScore() {
      this.answer += 0.1
    },
    decrementScore() {
      this.answer += -0.1
    },
    setScore(id) {
      axios
        .get(`/api/v1/games`, { params: { text: this.tweets[id].full_text } })
        .then((response) => (this.tweets[id].score = response.data))
    },
  },
  mounted() {
    const searches = Object.assign(
      { count: 5 },
      JSON.parse(JSON.stringify(this.$store.state.searches)),
      JSON.parse(JSON.stringify(this.$attrs))
    )
    axios.get(`/api/v1/tweets`, { params: searches }).then((response) => {
      this.tweets = response.data
      this.display_alert = this.tweets.length === 0
      for (let id = 0; id < this.tweets.length; id++) {
        this.setScore(id)
      }
    })
  },
  components: {
    TweetCard,
  },
}
</script>

<style scoped>
.bottom {
  position: fixed;
  left: 0px;
  bottom: 0;
  width: 100%;
  height: 110px;
  padding: 0.5rem;
  z-index: 10;
  background-color: #fff;
}
.twitter-color {
  background-color: #00acee !important;
  border-color: #00acee !important;
}
.score-view {
  text-align: center;
  border-top: 5px solid #00acee;
  border-bottom: 5px solid #00acee;
}
.score {
  font-size: 2rem !important;
}

.score-enter {
  opacity: 0;
}
.score-enter-to {
  opacity: 1;
}
.score-enter-active {
  transition: all 250ms;
}
.score-leave {
  opacity: 1;
}
.score-leave-to {
  opacity: 0;
}
.score-leave-active {
  transition: all 250ms;
}
</style>
