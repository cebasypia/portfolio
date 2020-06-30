<template>
  <form @submit.prevent="searchTweets">
    <div v-if="errors.length != 0">
      <ul v-for="error in errors" :key="error">
        <li><font color="red">{{ error }}</font></li>
      </ul>
    </div>
    <div>
      <label>Keyword</label>
      <input v-model="search.keyword" type="text">
    </div>
    <button type="submit">Commit</button>
  </form>
</template>

<script>
import axios from 'axios';

export default {
  data: function () {
    return {
      search: {
        keyword: '',
      },
      errors: ''
    }
  },
  methods: {
    searchTweets: function() {
      axios
        .post('/api/v1/tweets', this.search)
        .then(response => {
          let tweets = response.data;
          this.$router.push({ name: 'TweetsIndexPage' });
        })
        .catch(error => {
          console.error(error);
          if (error.response.data && error.response.data.errors) {
            this.errors = error.response.data.errors;
          }
        });
    }
  }
}
</script>

<style scoped>
</style>