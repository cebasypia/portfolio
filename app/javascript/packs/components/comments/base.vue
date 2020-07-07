<template>
  <div>
    <Card
      v-for="comment in comments"
      :comment="comment"
      :key="comment.id"
      @update="update"
    ></Card>
    <Form id="comment_form" @update="update"></Form>
  </div>
</template>

<script>
import Form from './form'
import Card from './card'
import axios from 'axios'
export default {
  data: function () {
    return {
      comments: [],
      dialog: false,
    }
  },
  mounted() {
    axios
      .get(`/api/v1/tweets/${this.$route.params.id}/comments`)
      .then((response) => (this.comments = response.data))
  },
  methods: {
    update() {
      axios
        .get(`/api/v1/tweets/${this.$route.params.id}/comments`)
        .then((response) => {
          this.comments = response.data
          this.dialog = false
        })
    },
  },
  components: {
    Form,
    Card,
  },
}
</script>

<style scoped>
#comment_form {
  position: fixed;
  bottom: 56px;
  left: 0;
  width: 100%;
  background-color: whitesmoke;
}
</style>
