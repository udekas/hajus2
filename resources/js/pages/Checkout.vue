<script setup lang="ts">
import { ref, onMounted } from 'vue';
import { useForm, usePage } from '@inertiajs/vue3';
import AppLayout from '@/layouts/AppLayout.vue';
import { Link } from '@inertiajs/vue3';
import axios from 'axios';

const page = usePage();

onMounted(() => {
  if (page.props.flash?.force_reload) {
    location.reload();
  }
});

const form = useForm({
  first_name: '',
  last_name: '',
  email: '',
  phone: '',
});

const submit = async () => {
  if (form.processing) return;

  form.processing = true;

  try {
    const response = await axios.post(route('checkout.process'), form.data());
    if (response.data?.url) {
      window.location.href = response.data.url;
    } else {
      alert('Unexpected response from server');
    }
  } catch (error) {
    console.error(error);
    alert('Something went wrong. Please try again.');
  } finally {
    form.processing = false;
  }
};

</script>

<template>
  <AppLayout>
    <div class="max-w-2xl w-full mx-auto p-8 bg-gradient-to-br from-blue-50 via-white to-blue-100 rounded-2xl shadow-xl border border-blue-100">
      <h1 class="text-3xl font-extrabold mb-8 text-blue-800 text-center tracking-tight drop-shadow">Checkout</h1>

      <!-- Error message -->
      <transition name="fade">
        <div
          v-if="$page.props.flash?.error"
          class="mb-6 p-4 bg-red-50 border border-red-200 text-red-700 rounded-lg flex items-center gap-2 shadow-sm"
        >
          <svg class="w-5 h-5 text-red-400" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" d="M12 8v4m0 4h.01M21 12A9 9 0 1 1 3 12a9 9 0 0 1 18 0z"/>
          </svg>
          <span>{{ $page.props.flash.error }}</span>
        </div>
      </transition>

      <form @submit.prevent="submit" class="space-y-6">
        <div>
          <label class="block mb-2 font-semibold text-gray-700">First Name</label>
          <input
            v-model="form.first_name"
            type="text"
            class="w-full border border-blue-200 rounded-lg p-3 focus:ring-2 focus:ring-blue-400 focus:outline-none transition"
            required
            placeholder="Enter your first name"
          />
        </div>

        <div>
          <label class="block mb-2 font-semibold text-gray-700">Last Name</label>
          <input
            v-model="form.last_name"
            type="text"
            class="w-full border border-blue-200 rounded-lg p-3 focus:ring-2 focus:ring-blue-400 focus:outline-none transition"
            required
            placeholder="Enter your last name"
          />
        </div>

        <div>
          <label class="block mb-2 font-semibold text-gray-700">Email</label>
          <input
            v-model="form.email"
            type="email"
            class="w-full border border-blue-200 rounded-lg p-3 focus:ring-2 focus:ring-blue-400 focus:outline-none transition"
            required
            placeholder="you@email.com"
          />
        </div>

        <div>
          <label class="block mb-2 font-semibold text-gray-700">Phone</label>
          <input
            v-model="form.phone"
            type="tel"
            class="w-full border border-blue-200 rounded-lg p-3 focus:ring-2 focus:ring-blue-400 focus:outline-none transition"
            required
            placeholder="+123456789"
          />
        </div>

        <div class="flex justify-between items-center pt-6">
          <Link
            href="/cart"
            class="text-sm text-blue-600 hover:underline hover:text-blue-800 transition"
          >
            ← Back to Cart
          </Link>

          <button
            type="submit"
            :disabled="form.processing"
            class="bg-gradient-to-r from-blue-500 to-blue-700 text-white px-8 py-3 rounded-lg font-semibold shadow hover:from-blue-600 hover:to-blue-800 transition disabled:opacity-60 disabled:cursor-not-allowed"
          >
            <span v-if="form.processing" class="flex items-center gap-2">
              <svg class="animate-spin h-5 w-5 text-white" fill="none" viewBox="0 0 24 24">
                <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
                <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8v8z"></path>
              </svg>
              Redirecting to Stripe...
            </span>
            <span v-else>
              Pay with Stripe
            </span>
          </button>
        </div>
      </form>
    </div>
  </AppLayout>
</template>

<style scoped>
.fade-enter-active, .fade-leave-active {
  transition: opacity 0.3s;
}
.fade-enter-from, .fade-leave-to {
  opacity: 0;
}
</style>
