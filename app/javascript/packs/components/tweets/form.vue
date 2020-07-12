<template>
  <v-form ref="form" v-model="valid" lazy-validation>
    <v-text-field
      v-model="word"
      label="キーワード検索"
      append-outer-icon="mdi-magnify"
      @click:append-outer="search"
      required
    ></v-text-field>
  </v-form>
</template>
<script>
export default {
  data: function () {
    return {
      valid: false,
      word: this.$store.state.searches.word,
    }
  },
  methods: {
    search() {
      this.$store.commit('setSearches', {
        word: this.word,
      })
      this.$emit('search', this.search_word)
    },
  },
}
</script>

<style scoped></style>
