
import 'package:floor/floor.dart';
import 'package:todo_app/data/datasources/local/db/dbentities/task/task_entity.dart';


@dao
abstract class TaskDao {
  @Query("select * from task")
  Future<List<TaskEntity>?> getTasks();

  @Query('SELECT * FROM task WHERE isSynced = 0')
  Future<List<TaskEntity>?> getUnsyncedTasks();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> save(List<TaskEntity> tasks);

  @Query("select * from task WHERE id = :id")
  Future<TaskEntity?> getTaskById(String id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insert(TaskEntity updateTaskEntity);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateTask(TaskEntity updateTaskEntity);

  @Query("DELETE FROM task WHERE id = :id")
  Future<void> deleteTaskById(String id);

  @Query("UPDATE task SET isCompleted = :isCompleted WHERE id = :id")
  Future<void> updateIsCompleted(String id, bool isCompleted);

  @Query("DELETE FROM task")
  Future<void> deleteAll();

}