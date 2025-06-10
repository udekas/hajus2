<script setup>
import AppLayout from '@/layouts/AppLayout.vue';
</script>

<template>
  <AppLayout>
    <div class="max-w-xl mx-auto p-10 mt-20 bg-white rounded-xl shadow-lg text-center animate-fade-in">
      <div class="flex justify-center mb-6">
        <svg class="w-16 h-16 text-red-500" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 48 48">
          <circle cx="24" cy="24" r="22" stroke="currentColor" stroke-width="4" fill="#fee2e2"/>
          <path stroke-linecap="round" stroke-linejoin="round" d="M16 16l16 16M32 16L16 32" stroke="red" stroke-width="4"/>
        </svg>
      </div>
      <h1 class="text-4xl font-extrabold text-red-600 mb-4">Payment Cancelled</h1>
      <p class="text-gray-600 text-lg mb-6">Your payment was cancelled. You can try again later.</p>
      <router-link to="/" class="inline-block px-6 py-2 bg-red-500 text-white rounded-lg shadow hover:bg-red-600 transition">
        Back to Home
      </router-link>
    </div>
  </AppLayout>
</template>

<style scoped>
@keyframes fade-in {
  from { opacity: 0; transform: translateY(20px);}
  to { opacity: 1; transform: translateY(0);}
}
.animate-fade-in {
  animation: fade-in 0.7s cubic-bezier(.4,0,.2,1);
}
</style>
