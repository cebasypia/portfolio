<template>
  <div id="tweets">
    <div class="tweet" v-for="tweet in tweets" :key="tweet.id">
      <div class="info">
        <div class="user">
          <img :src="tweet.user.profile_image_url_https" alt="user profile image">
        </div>
        {{ tweet.user.name }}
      </div>
      <div class="text">
        {{ tweet.full_text }}
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data: function () {
    return {
      tweets: []
    }
  },
  mounted () {
    axios
      .get(`/api/v1/tweets/index`)
      .then(response => (this.tweets = response.data))
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>