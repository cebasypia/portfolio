<template>
  <v-card class="align-center mx-auto">
    <v-list-item two-line>
      <UserImage :size="42" :user="comment.user"></UserImage>
      <v-list-item-content>
        <v-list-item-title>
          {{ comment.user_name }}
        </v-list-item-title>
      </v-list-item-content>
    </v-list-item>
    <v-card-text>{{ comment.content }}</v-card-text>
    <v-card-actions>
      <v-list-item class="grow">
        <v-row align="center" justify="end">
          <v-icon color="red" @click="destroyComment(comment.id)"
            >mdi-delete</v-icon
          >
        </v-row>
      </v-list-item>
    </v-card-actions>
  </v-card>
</template>
<script>
import axios from 'axios'

import UserImage from '../../components/userImage.vue'

export default {
  props: ['comment'],
  data: function () {
    return {}
  },
  methods: {
    destroyComment(id) {
      axios.delete(`/api/v1/comments/${id}`).then(() => {
        this.$emit('update')
      })
    },
  },
  components: {
    UserImage,
  },
}
</script>

<style scoped>
.v-card {
  margin: 1rem;
}
</style>
