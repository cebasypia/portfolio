<template>
  <v-app>
  <AppBar></AppBar>
    <router-view></router-view>
  </v-app>
</template>

<script>
import AppBar from './packs/components/appBar.vue'

export default {
  components : {
    AppBar
  }
}
</script>

<style scoped>
</style>