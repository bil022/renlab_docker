<template>
  <v-container class="fill-height">
    <v-responsive class="align-center text-center fill-height">
      <v-form @submit.prevent>
        <v-table>
          <tbody>
            <tr v-for="item in data" :key="item.name">
            <td><v-text-field v-model="item.value" :label="item.label"></v-text-field></td>
            </tr>
          </tbody>
        </v-table>
        <!-- v-file-input v-model="thumb" accept="image/*" show-size label="Thumb image"></v-file-input -->
        <v-btn type="submit" block class="mt-2" @click="upload">Submit</v-btn>
        <v-row>
          <v-col><a href="https://imgur.com/upload" target="_thumb">Upload thumb image</a><br/></v-col>
          <v-col v-if="doi"><a :href="doi" target="_doi">doi</a><br/></v-col>
          <v-col v-if="link"><a :href="link" target="_link">link</a></v-col>
        </v-row>
        <v-row>
          <v-col><v-img :src="image_url"/></v-col>
        </v-row>
      </v-form>
    </v-responsive>
  </v-container>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue'
import { fetchData, postData } from './api'
  var data =ref([{ "name": "", "label":"", "value": "" }])
  var image_url = ref("")
  var thumb = ref();
  (async () => {
    try {
      const response = await fetchData();
      data.value=response.data.json;
      image_url.value = response.data.thumb;
    } catch (error) {
      console.error('Error fetching data:', error);
    }
  })()
  var doi = computed(()=>{
    let item=data.value.find(x=>x.name=='doi');
    return item?item.value:'';
  })
  var link = computed(()=>{
    let item=data.value.find(x=>x.name=='full_text_link');
    return item?item.value:'';
  })
  const upload = async () => {
    try {
      const response = await postData(data.value);
      console.log(response.data);
    } catch (error) {
      console.error('Error fetching data:', error);
    }
  };

</script>
