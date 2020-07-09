import axios from 'axios'

export default {
  state: {
    auth: {
      logged_in: false,
      current_user: {},
    },
  },
  setLoggedIn() {
    axios.get('/api/v1/logged_in').then((response) => {
      this.state.auth.logged_in = response.data
      console.log(`logged_in: ${this.state.auth.logged_in}`)
    })
  },
  setCurrentUser() {
    axios.get('/api/v1/current_user').then((response) => {
      this.state.auth.current_user = response.data
      console.log(`current_user: ${this.state.auth.current_user}`)
    })
  },
  refresh() {
    this.setLoggedIn()
    this.setCurrentUser()
  },
}
