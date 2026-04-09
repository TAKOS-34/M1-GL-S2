import { Route } from '@angular/router';
import { Products } from './products/products';
import { Cart } from './cart/cart';
import { Homepage } from './homepage/homepage';

export const routes: Route[] = [
    { path: '', component: Homepage, pathMatch: 'full' },
    { path: 'products', component: Products },
    { path: 'cart', component: Cart },
];