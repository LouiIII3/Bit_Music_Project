<template>
  <div>
    <div class="text-center pa-4">
      <v-btn @click="openDialog" style="position:absolute; bottom:10px; right:100px;">
        QR CODE
      </v-btn>

      <v-dialog v-model="dialog" width="auto">
        <v-card max-width="1000">
          <v-card-text class="d-flex justify-center">
            <vue-qrcode :size="1000" :value="qrDataString" type="image/png" />
          </v-card-text>
        </v-card>
      </v-dialog>
    </div>
  </div>
</template>

<script>
import VueQrcode from 'vue-qrcode';

export default {
  components: {
    VueQrcode
  },
  data() {
    return {
      dialog: false,
      qrDataString: ''
    };
  },
  methods: {
    openDialog() {
      this.loadData();
      this.dialog = true;
    },
    loadData() {
      const dataArray1 = JSON.parse(localStorage.getItem('exercise_data')) || [];

        this.qrDataString = JSON.stringify(dataArray1);


      console.log("QR Data String:", this.qrDataString);
    }
  }
};
</script>

<style>
</style>
