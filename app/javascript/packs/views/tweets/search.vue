<template>
  <v-form ref="form" v-model="valid" class="ma-2">
    <v-text-field
      v-model="search.word"
      :rules="wordRules"
      label="search word"
      required
    ></v-text-field>
    <v-btn :disabled="!valid" color="success" right @click="searchTweets">
      検索
    </v-btn>
  </v-form>
</template>

<script>
export default {
  data: function () {
    return {
      valid: false,
      search: {
        word: '',
      },
      wordRules: [(v) => !!v || 'Search word is required'],
      errors: '',
    }
  },
  methods: {
    searchTweets() {
      this.$router.push({
        name: 'TweetsIndexPage',
        params: { word: this.search.word },
      })
    },
  },
}
</script>

<style scoped></style>
