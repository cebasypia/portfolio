<template>
  <v-list-item-avatar
    :size="size"
    color="grey"
    @click="linkTo('UsersShowPage', { id: user.id })"
  >
    <v-img :src="user.image_url"></v-img>
  </v-list-item-avatar>
</template>

<script>
import router from '../router.js'

export default {
  props: {
    size: {
      type: Number,
      default: 73,
    },
    user: Object,
    is_link: {
      type: Boolean,
      default: true,
    },
  },
  methods: {
    linkTo(name, params) {
      if (this.is_link) {
        router.push({ name: name, params: params })
      }
    },
  },
}
</script>
