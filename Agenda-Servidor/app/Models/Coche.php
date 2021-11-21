<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Notifications\Notifiable;

class Coche extends Model
{
    use HasFactory, Notifiable;
    protected $fillable = [
        'habilitado',
        'matricula',
    ];
    protected $hidden = [
        'created_at',
        'updated_at',
        'habilitado',
    ];
}
