<template>
  <v-form ref="form" v-model="valid" lazy-validation>
    <v-text-field
      v-model="search_word"
      label="キーワード検索"
      append-outer-icon="mdi-magnify"
      @click:append-outer="search"
      required
    ></v-text-field>
  </v-form>
</template>
<script>
export default {
  data: () => ({
    valid: false,
    search_word: '',
  }),
  methods: {
    search() {
      this.$emit('search', this.search_word)
    },
  },
}
</script>

<style scoped></style>
