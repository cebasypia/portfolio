<template>
  <v-form ref="form" v-model="valid" lazy-validation>
    <v-textarea
      id="comment_content"
      v-model="comment"
      :counter="140"
      :rules="commentRules"
      label="comment"
      auto-grow
      rows="1"
      row-height="2rem"
      append-outer-icon="mdi-send"
      @click:append-outer="createComment"
      required
    ></v-textarea>
  </v-form>
</template>
<script>
import axios from 'axios'

export default {
  data: () => ({
    valid: false,
    comment: '',
    commentRules: [
      (v) => !!v || 'comment is required',
      (v) => (v && v.length <= 140) || 'Name must be less than 140 characters',
    ],
  }),
  methods: {
    createComment() {
      axios
        .post(`/api/v1/comments`, {
          tweet_id: this.$route.params.id,
          content: this.comment,
        })
        .then((response) => {
          this.tweet = response.data
          this.$emit('update')
          this.comment = ''
          this.$refs.form.reset()
        })
        .catch(() => {})
    },
  },
}
</script>

<style scoped></style>
