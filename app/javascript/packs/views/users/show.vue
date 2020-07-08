<template>
  <v-container fluid>
    <v-card>
      <v-list-item two-line>
        <v-list-item-avatar size="73" color="grey">
          <v-img src=""></v-img>
        </v-list-item-avatar>
        <v-list-item-content>
          <v-list-item-title class="user-name">
            {{ user.name }}
          </v-list-item-title>
        </v-list-item-content>
      </v-list-item>
      <v-card-text class="text">{{ user.profile }}</v-card-text>
    </v-card>
    <v-tabs fixed-tabs light color="amber darken-2">
      <v-tab> よんだ！: {{ Object.keys(readTweets).length }} </v-tab>
      <v-tab>
        かいた！
      </v-tab>
      <v-tab-item>
        <tweetCard
          v-for="tweet in readTweets"
          :tweet="tweet"
          :key="tweet.id"
        ></tweetCard>
      </v-tab-item>
      <v-tab-item> </v-tab-item>
    </v-tabs>
  </v-container>
</template>

<script>
import TweetCard from '../../components/tweetCard.vue'
import axios from 'axios'

export default {
  data: function () {
    return {
      user: {},
      readTweets: {},
    }
  },
  mounted() {
    axios
      .get(`/api/v1/users/${this.$route.params.id}.json`)
      .then((response) => {
        this.user = response.data.user
        this.readTweets = response.data.tweets
      })
  },
  components: {
    TweetCard,
  },
}
</script>

<style scoped></style>
