
<script setup lang="ts">
import { Card, CardContent, CardDescription, CardFooter, CardHeader, CardTitle } from '@/components/ui/card';
import { Dialog, DialogContent, DialogDescription, DialogHeader, DialogTitle } from '@/components/ui/dialog';
import AppLayout from '@/layouts/AppLayout.vue';
import { type BreadcrumbItem } from '@/types';
import { Head, useForm, router } from '@inertiajs/vue3';
import { MapMouseEvent } from 'maplibre-gl';
import Radar from 'radar-sdk-js';
import 'radar-sdk-js/dist/radar.css';
import RadarMap from 'radar-sdk-js/dist/ui/RadarMap';
import { onMounted, ref } from 'vue';

const breadcrumbs: BreadcrumbItem[] = [
    { title: 'Töölaud', href: '/dashboard' },
];

const props = defineProps({
    weather: { type: Object, required: true },
    markers: { type: Array, required: true },
});

const form = useForm({
    title: '',
    description: '',
    latitude: 0,
    longitude: 0,
});

const show = ref(false);
const confirmDelete = ref(false);
const selectedMarker = ref<{ id: number; name: string; description: string; latitude: number; longitude: number } | null>(null);
const map = ref<RadarMap>();

Radar.initialize('prj_live_pk_581819a64edfdc6543371d189067bff15b1a6314', {});

onMounted(() => {
    const radarMap = Radar.ui.map({
        container: 'map',
        style: 'radar-default-v1',
        center: [22.488819593503443, 58.25398239259826],
        zoom: 14,
    });

    map.value = radarMap;

    for (let marker of props.markers as Array<{ id: number; name: string; description: string; latitude: number; longitude: number }>) {
        const radarMarker = Radar.ui
            .marker({ color: '#000257', width: 40, height: 80 })
            .setLngLat([marker.longitude, marker.latitude])
            .addTo(radarMap);

        radarMarker.on('click', () => {
            selectedMarker.value = marker;
            form.title = marker.name;
            form.description = marker.description;
            form.latitude = marker.latitude;
            form.longitude = marker.longitude;
            show.value = true;
        });
    }

    radarMap.on('click', (e: MapMouseEvent) => {
        form.reset();
        form.latitude = e.lngLat.lat;
        form.longitude = e.lngLat.lng;
        selectedMarker.value = null;
        show.value = true;
    });
});

function handleSubmit() {
    form.post(route('markers.store'), {
        onSuccess: () => {
            form.reset();
            show.value = false;
            location.reload();
        }
    });
}

function updateMarker() {
    if (!selectedMarker.value) return;
    form.put(`/markers/${selectedMarker.value.id}`, {
        onSuccess: () => {
            form.reset();
            selectedMarker.value = null;
            show.value = false;
            location.reload();
        }
    });
}

function confirmDeleteMarker() {
    confirmDelete.value = true;
}

function reallyDeleteMarker() {
    if (!selectedMarker.value) return;
    router.delete(`/markers/${selectedMarker.value.id}`, {
        onSuccess: () => {
            confirmDelete.value = false;
            selectedMarker.value = null;
            show.value = false;
            location.reload();
        }
    });
}
</script>

<template>
  <Head title="Dashboard" />
  <AppLayout :breadcrumbs="breadcrumbs">
    <div class="flex flex-col gap-6 rounded-xl p-6 bg-gradient-to-br from-[#1a120b] via-[#2d1b12] to-[#3e2723] min-h-screen">
      
      <!-- Weather Card -->
      <div class="grid gap-6 md:grid-cols-3">
        <Card class="bg-gradient-to-br from-[#3e2723] to-[#4e342e] text-white shadow-lg border-none">
          <CardHeader class="flex flex-row items-center justify-between pb-2">
            <CardTitle class="text-base font-semibold tracking-wide">Weather</CardTitle>
            <img
              :src="'http://openweathermap.org/img/wn/' + weather.weather[0].icon + '@2x.png'"
              alt="Weather icon"
              class="bg-white rounded-lg h-14 w-14 shadow"
            />
          </CardHeader>
          <CardContent>
            <div class="text-3xl font-extrabold mb-1">{{ weather.main.temp }}°C</div>
            <p class="text-xs text-gray-300 italic">
              {{ weather.wind.speed }} m/s &mdash; {{ weather.weather[0].description }}
            </p>
          </CardContent>
        </Card>
      </div>

      <!-- Map Section -->
      <div class="relative flex-1 min-h-[60vh] overflow-hidden rounded-xl border border-[#4e342e] shadow-lg">
        <div id="map" class="w-full h-full" />
      </div>

      <!-- Marker Dialog -->
      <Dialog :open="show" @update:open="show = $event">
        <DialogContent class="bg-gradient-to-br from-[#3e2723] to-[#4e342e] text-white rounded-xl shadow-xl border-none">
          <DialogHeader>
            <DialogTitle class="text-lg font-bold">
              {{ selectedMarker ? 'Muuda markerit' : 'Uus marker' }}
            </DialogTitle>
            <DialogDescription class="text-sm text-gray-300">
              {{ selectedMarker ? 'Redigeeri olemasolevat markerit' : 'Lisa uus marker kaardilt klikkides' }}
            </DialogDescription>
          </DialogHeader>
          <form class="space-y-5 mt-4" @submit.prevent="handleSubmit">
            <div>
              <label for="title" class="block text-sm font-medium mb-1">Title</label>
              <input
                id="title"
                type="text"
                class="w-full rounded-md border border-[#4e342e] bg-[#1a120b] text-white px-3 py-2 focus:outline-none focus:ring-2 focus:ring-[#6d4c41] transition"
                v-model="form.title"
                autocomplete="off"
              />
            </div>
            <div>
              <label for="description" class="block text-sm font-medium mb-1">Description</label>
              <textarea
                id="description"
                rows="3"
                class="w-full rounded-md border border-[#4e342e] bg-[#1a120b] text-white px-3 py-2 focus:outline-none focus:ring-2 focus:ring-[#6d4c41] transition"
                v-model="form.description"
              />
            </div>
            <div class="flex gap-4 mt-6 justify-end">
              <button
                v-if="selectedMarker"
                type="button"
                @click="updateMarker"
                class="px-5 py-2 rounded-lg bg-[#6d4c41] hover:bg-[#4e342e] transition text-white font-semibold shadow"
              >
                Salvesta muudatused
              </button>
              <button
                v-if="selectedMarker"
                type="button"
                @click="confirmDeleteMarker"
                class="px-5 py-2 rounded-lg bg-red-700 hover:bg-red-900 transition text-white font-semibold shadow"
              >
                Kustuta marker
              </button>
              <input
                v-if="!selectedMarker"
                type="submit"
                value="Salvesta uus"
                class="px-5 py-2 rounded-lg bg-[#3e2723] hover:bg-[#4e342e] transition text-white font-semibold shadow cursor-pointer"
              />
            </div>
          </form>
        </DialogContent>
      </Dialog>

      <!-- Delete Confirmation Dialog -->
      <Dialog :open="confirmDelete" @update:open="confirmDelete = $event">
        <DialogContent class="bg-gradient-to-br from-[#3e2723] to-[#4e342e] text-white rounded-xl shadow-xl border-none">
          <DialogHeader>
            <DialogTitle class="text-lg font-bold">Kustuta marker</DialogTitle>
            <DialogDescription class="text-sm text-gray-300">
              Oled kindel, et soovid selle markeri kustutada?
            </DialogDescription>
          </DialogHeader>
          <div class="flex justify-end gap-4 mt-6">
            <button
              @click="confirmDelete = false"
              class="px-5 py-2 rounded-lg bg-[#1a120b] hover:bg-[#3e2723] transition text-white font-semibold shadow"
            >
              Tühista
            </button>
            <button
              @click="reallyDeleteMarker"
              class="px-5 py-2 rounded-lg bg-red-700 hover:bg-red-900 transition text-white font-semibold shadow"
            >
              Kustuta
            </button>
          </div>
        </DialogContent>
      </Dialog>
    </div>
  </AppLayout>
</template>