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
      console.log(response.data)
      this.state.auth.logged_in = response.data
    })
  },
  setCurrentUser() {
    axios
      .get('/api/v1/current_user')
      .then((response) => (this.state.auth.current_user = response.data))
  },
  refresh() {
    this.setLoggedIn()
    this.setCurrentUser()
  },
}
