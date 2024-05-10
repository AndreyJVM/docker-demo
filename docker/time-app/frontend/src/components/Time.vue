<script>
import moment from 'moment'
import { startInterval, saveTime, deleteTime } from '../utils/time'

export default {
  props: {
    showSavedTimes: Boolean,
  },
  data() {
    return {
      currentTime: moment().format('HH:mm:ss'),
      savedTimes: [],
    }
  },
  methods: {
    startInterval,
    saveTime,
    deleteTime,
  },
  created: async function () {
    this.startInterval()
    const res = await fetch('http://localhost:5555/times')
    const json = await res.json()
    if (json.length) this.savedTimes = json
  },
}
</script>

<template>
  <div class="greetings">
    <h1 class="green">{{ currentTime }}</h1>
    <h3>Нажмите кнопку для сохранения в базе данных</h3>
    <button @click="saveTime">Сохранить время</button>
    <h3 v-if="savedTimes.length && showSavedTimes">
      Ранее сохраненные времена:
    </h3>
    <div
      v-if="showSavedTimes"
      class="deleted-items"
      v-for="savedTime in savedTimes"
      :key="savedTime.id"
    >
      <div class="deleted-item">{{ savedTime.time }}</div>
      <button class="btn-sm bg-red" @click="() => deleteTime(savedTime.id)">
        Удалить
      </button>
    </div>
  </div>
</template>

<style scoped>
h1 {
  font-weight: 500;
  font-size: 4rem;
  top: -10px;
}

h3 {
  font-size: 2rem;
}

button {
  font-size: 1.5rem;
  margin: 30px;
  background-color: rgb(128, 184, 244);
  border-radius: 5px;
  border: none;
  padding: 10px;
  cursor: pointer;
}

.btn-sm {
  margin: 10px;
  padding: 4px;
}

.bg-red {
  background-color: rgb(184, 93, 93);
}

.deleted-items {
  font-size: 1.7rem;
}

.deleted-item {
  width: 150px;
  display: inline-block;
}

.greetings {
  text-align: center;
}
</style>
