import Vue from 'vue'
import Vuex from 'vuex'
import createPersistedState from 'vuex-persistedstate'
import axios from 'axios'

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    auth: {
      current_user: {},
      logged_in: false,
    },
  },
  getters: {},
  mutations: {
    setAuth(state, auth) {
      state.auth = auth
    },
  },
  actions: {
    resetAuth(context) {
      axios
        .get('/api/v1/auth')
        .then((response) => context.commit('setAuth', response.data))
    },
  },
  plugins: [createPersistedState()],
})
