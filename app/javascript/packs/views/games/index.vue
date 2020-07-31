<template>
  <v-container fluid>
    <v-form ref="form" v-model="valid" class="ma-2">
      <v-text-field
        v-model="searches.word"
        :rules="wordRules"
        label="検索キーワード"
        required
      ></v-text-field>
      <v-select
        v-model="searches.lang"
        item-text="label"
        item-value="code"
        :items="languages"
        label="言語"
        return-object
      ></v-select>
      <v-select
        v-model="searches.result_type"
        item-text="label"
        item-value="code"
        :items="result_types"
        label="検索方法"
        return-object
      ></v-select>
      <v-text-field
        v-model="searches.user"
        label="@ユーザーID"
        hint="特定のユーザーが投稿したツイート"
        persistent-hint
        clearable
      ></v-text-field>
      <div class="text-center">
        <v-btn
          class="play-button"
          :disabled="!valid"
          rounded
          dark
          @click="play"
        >
          PLAY
        </v-btn>
      </div>
    </v-form>
  </v-container>
</template>

<script>
export default {
  data: function () {
    return {
      valid: false,
      dialog: false,
      searches: {
        word: this.$store.state.searches.word,
        lang: this.$store.state.searches.lang,
        result_type: this.$store.state.searches.result_type,
        user: this.$store.state.searches.user,
      },
      languages: [
        { label: '英語', code: 'en' },
        { label: '日本語', code: 'ja' },
      ],
      result_types: [
        // { label: '人気 & 最新', code: 'mixed' },
        { label: '人気', code: 'popular' },
        { label: '最新', code: 'recent' },
      ],
      wordRules: [(v) => !!v || 'Search word is required'],
      errors: '',
    }
  },
  methods: {
    play() {
      this.searches.lang = this.searches.lang.code || this.searches.lang
      this.searches.result_type =
        this.searches.result_type.code || this.searches.result_type
      this.$store.commit('setSearches', this.searches)
      this.$router.push({
        name: 'GamesPlayPage',
      })
    },
  },
}
</script>

<style scoped>
.play-button {
  margin-top: 1rem;
  background-color: #00acee !important;
  border-color: #00acee !important;
}
</style>
