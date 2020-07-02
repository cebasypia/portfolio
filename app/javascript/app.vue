<template>
  <v-app>
    <AppBar></AppBar>
    <v-main>
      <router-view></router-view>
    </v-main>
    <ToolBar></ToolBar>
  </v-app>
</template>

<script>
import AppBar from './packs/components/appBar.vue'
import ToolBar from './packs/components/toolBar.vue'

export default {
  components: {
    AppBar,
    ToolBar,
  },
}
</script>

<style scoped></style>
