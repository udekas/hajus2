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
    <div class="max-w-2xl w-full mx-auto p-10 bg-white/80 backdrop-blur-md rounded-3xl shadow-2xl border border-blue-100 relative overflow-hidden">
      <!-- Decorative Gradient Circles -->
      <div class="absolute -top-10 -left-10 w-40 h-40 bg-blue-100 rounded-full opacity-40 blur-2xl pointer-events-none"></div>
      <div class="absolute -bottom-16 -right-16 w-56 h-56 bg-blue-300 rounded-full opacity-30 blur-3xl pointer-events-none"></div>

      <h1 class="text-4xl font-black mb-10 text-blue-900 text-center tracking-tight drop-shadow-lg">
        <span class="bg-gradient-to-r from-blue-500 via-blue-400 to-blue-700 bg-clip-text text-transparent">Checkout</span>
      </h1>

      <!-- Error message -->
      <transition name="fade">
        <div
          v-if="$page.props.flash?.error"
          class="mb-8 p-4 bg-red-100/80 border border-red-300 text-red-800 rounded-xl flex items-center gap-3 shadow"
        >
          <svg class="w-6 h-6 text-red-400" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" d="M12 8v4m0 4h.01M21 12A9 9 0 1 1 3 12a9 9 0 0 1 18 0z"/>
          </svg>
          <span class="font-medium">{{ $page.props.flash.error }}</span>
        </div>
      </transition>

      <form @submit.prevent="submit" class="space-y-7">
        <div>
          <label class="block mb-2 font-semibold text-blue-800 tracking-wide">First Name</label>
          <input
            v-model="form.first_name"
            type="text"
            class="w-full border border-blue-200 rounded-xl p-3 bg-white/80 focus:ring-2 focus:ring-blue-400 focus:outline-none transition shadow-sm"
            required
            placeholder="Enter your first name"
            autocomplete="given-name"
          />
        </div>

        <div>
          <label class="block mb-2 font-semibold text-blue-800 tracking-wide">Last Name</label>
          <input
            v-model="form.last_name"
            type="text"
            class="w-full border border-blue-200 rounded-xl p-3 bg-white/80 focus:ring-2 focus:ring-blue-400 focus:outline-none transition shadow-sm"
            required
            placeholder="Enter your last name"
            autocomplete="family-name"
          />
        </div>

        <div>
          <label class="block mb-2 font-semibold text-blue-800 tracking-wide">Email</label>
          <input
            v-model="form.email"
            type="email"
            class="w-full border border-blue-200 rounded-xl p-3 bg-white/80 focus:ring-2 focus:ring-blue-400 focus:outline-none transition shadow-sm"
            required
            placeholder="you@email.com"
            autocomplete="email"
          />
        </div>

        <div>
          <label class="block mb-2 font-semibold text-blue-800 tracking-wide">Phone</label>
          <input
            v-model="form.phone"
            type="tel"
            class="w-full border border-blue-200 rounded-xl p-3 bg-white/80 focus:ring-2 focus:ring-blue-400 focus:outline-none transition shadow-sm"
            required
            placeholder="+123456789"
            autocomplete="tel"
          />
        </div>

        <div class="flex justify-between items-center pt-8">
          <Link
            href="/cart"
            class="text-sm text-blue-600 hover:underline hover:text-blue-800 transition font-medium"
          >
            ← Back to Cart
          </Link>

          <button
            type="submit"
            :disabled="form.processing"
            class="bg-gradient-to-r from-blue-500 via-blue-600 to-blue-700 text-white px-10 py-3 rounded-xl font-bold shadow-lg hover:from-blue-600 hover:to-blue-900 transition-all duration-200 disabled:opacity-60 disabled:cursor-not-allowed flex items-center gap-2"
          >
            <svg v-if="form.processing" class="animate-spin h-5 w-5 text-white" fill="none" viewBox="0 0 24 24">
              <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
              <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8v8z"></path>
            </svg>
            <span>
              {{ form.processing ? 'Redirecting to Stripe...' : 'Pay with Stripe' }}
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
