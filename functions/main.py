from firebase_functions import https_fn
from firebase_admin import initialize_app, firestore

# Inicializar la aplicación de Firebase
initialize_app()

# Obtener referencia a Firestore
db = firestore.client()

# Crear cuenta de usuario
@https_fn.on_request()
def create_user(req: https_fn.Request) -> https_fn.Response:
    data = req.get_json()
    user_id = data.get('user_id')
    user_info = {
        'name': data.get('name'),
        'email': data.get('email'),
        'role': data.get('role')  # 'client' o 'trainer'
    }
    db.collection('users').document(user_id).set(user_info)
    return https_fn.Response(f"User {user_id} created successfully", status=201)

# Asignar entrenador a cliente
@https_fn.on_request()
def assign_trainer(req: https_fn.Request) -> https_fn.Response:
    data = req.get_json()
    client_id = data.get('id')
    trainer_id = data.get('trainerId')

    client_ref = db.collection('users').document(client_id)
    client_ref.update({'trainerId': trainer_id})
    return https_fn.Response(f"Trainer {trainer_id} assigned to client {client_id}", status=200)

# Gestionar sesión de entrenamiento
@https_fn.on_request()
def manage_training_session(req: https_fn.Request) -> https_fn.Response:
    data = req.get_json()
    session_id = data.get('session_id')
    session_info = {
        'client_id': data.get('client_id'),
        'trainer_id': data.get('trainer_id'),
        'date': data.get('date'),
        'duration': data.get('duration'),
        'activities': data.get('activities')  # lista de actividades realizadas
    }
    db.collection('training_sessions').document(session_id).set(session_info)
    return https_fn.Response(f"Training session {session_id} managed successfully", status=200)

# Obtener estadísticas de entrenamiento
@https_fn.on_request()
def get_training_stats(req: https_fn.Request) -> https_fn.Response:
    client_id = req.args.get('client_id')
    sessions = db.collection('training_sessions').where('client_id', '==', client_id).stream()

    total_duration = 0
    activities_count = {}

    for session in sessions:
        session_data = session.to_dict()
        total_duration += session_data.get('duration', 0)

        for activity in session_data.get('activities', []):
            if activity in activities_count:
                activities_count[activity] += 1
            else:
                activities_count[activity] = 1

    stats = {
        'total_duration': total_duration,
        'activities_count': activities_count
    }

    return https_fn.Response(stats, status=200)

