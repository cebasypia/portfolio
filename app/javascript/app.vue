<template>
  <v-app>
    <AppBar :current_user="current_user"></AppBar>
    <v-main>
      <router-view></router-view>
    </v-main>
    <ToolBar></ToolBar>
  </v-app>
</template>

<script>
import AppBar from './packs/components/appBar.vue'
import ToolBar from './packs/components/toolBar.vue'
import axios from 'axios'

export default {
  data: () => {
    return {
      current_user: null,
    }
  },
  mounted() {
    axios
      .get('/api/v1/logged_in')
      .then((response) => (this.current_user = response.data))
  },
  components: {
    AppBar,
    ToolBar,
  },
  watch: {
    $route: function (to, from) {
      if (to.path !== from.path) {
        axios
          .get('/api/v1/logged_in')
          .then((response) => (this.current_user = response.data))
      }
    },
  },
}
</script>

<style scoped></style>
