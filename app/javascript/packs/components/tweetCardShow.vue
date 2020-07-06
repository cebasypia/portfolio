<template>
  <v-card>
    <TweetCard :tweet="tweet"></TweetCard>
    <v-row v-if="detail" justify="space-around" fill-height class="info-row">
      <v-col cols="auto">
        <div v-if="is_read">
          <v-icon @click="deleteRead">mdi-heart</v-icon>よんだ！
        </div>
        <div v-else>
          <v-icon @click="createRead">mdi-heart-outline</v-icon>よんだ！
        </div>
      </v-col>
      <v-col cols="auto"> <v-icon>mdi-heart</v-icon>かいた！ </v-col>
    </v-row>
  </v-card>
</template>
<script>
import axios from 'axios'
import TweetCard from './tweetCard'
export default {
  props: ['current_user', 'detail'],
  data: function () {
    return {
      tweet: [],
      is_read: false,
    }
  },
  mounted() {
    axios.get(`/api/v1/tweets/${this.$route.params.id}`).then((response) => {
      this.tweet = response.data
      axios
        .post(`/api/v1/tweets/is_read`, { tweet_id: this.tweet.id })
        .then((response) => (this.is_read = response.data))
    })
  },
  methods: {
    createRead: function () {
      axios
        .post(`/api/v1/reads`, {
          tweet_id: this.tweet.id,
        })
        .then((response) => (this.is_read = response.data))
    },
    deleteRead: function () {
      axios
        .delete(`/api/v1/reads/${this.tweet.id}`)
        .then((response) => (this.is_read = response.data))
    },
  },
  components: {
    TweetCard,
  },
}
</script>

<style scoped>
a {
  text-decoration: none;
}
.text {
  color: rgba(0, 0, 0, 0.87);
}
.user-name {
  color: rgba(0, 0, 0, 0.87);
}
.info-row {
  font-size: 12px;
  color: rgba(0, 0, 0, 0.6);
}
.icon-twitter {
  color: rgb(29, 161, 242);
}
</style>
