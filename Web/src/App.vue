<template>
  <div id="app">
    <mv_net />
  </div>
</template>

<script>
import mv_net from './components/main.vue';

export default {
  name: 'App',
  components: {
    mv_net,
  },
};

</script>

<style>
#app {
  font-family: Arial, sans-serif;
  text-align: center;
  margin-top: 20px;
}
</style>
